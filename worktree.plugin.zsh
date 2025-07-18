#!/usr/bin/env zsh
# This script makes working with workree's a bit nicer.

WORKTREE_CODE_DIR=${WORKTREE_CODE_DIR:-../*}
WORKTREE_POST_SWITCH=${WORKTREE_POST_SWITCH:-echo switched}
WORKTREE_POST_CREATE=${WORKTREE_POST_CREATE:-echo created}

function git_root(){
    if [ -d ./.git ]; then 
        echo "in git root $PWD"
    elif [ $PWD = "/" ]; then
        echo "Got to / and did not find a .git directory" > /dev/stderr
        exit 1
    else
        pushd .. > /dev/null
        git_root
    fi    
}

export function worktree-remove(){
    git_root
    BRANCH=$1
    WORKTREE_BASE="../$(basename $PWD)-worktree"
    DIRNAME="$WORKTREE_BASE/$BRANCH"
    
    if [ -d "$DIRNAME" ]; then
        echo "Removing worktree for branch '$BRANCH' at '$DIRNAME'"
        echo "→ git worktree remove $DIRNAME"
        git worktree remove $DIRNAME
    else
        echo "Worktree for branch '$BRANCH' not found at '$DIRNAME'"
        echo "Available worktrees:"
        git worktree list
    fi
}

export function origin_branch(){
   git branch -a  --sort=committerdate
}

export function worktree(){
    git_root
    BRANCH=$1
    WORKTREE_BASE="../$(basename $PWD)-worktree"
    DIRNAME="$WORKTREE_BASE/$BRANCH"
    
    # Ensure the base worktree directory exists
    mkdir -p "$WORKTREE_BASE"

    if origin_branch | grep $BRANCH; then 
        echo "branch '$BRANCH' exists checking out into '$DIRNAME'"
        echo "→ git worktree add $DIRNAME $BRANCH"
        git worktree add $DIRNAME $BRANCH
        pushd > /dev/null
        $=WORKTREE_POST_CREATE
        popd > /dev/null
    elif git worktree list | grep -q "\[${BRANCH}\]"; then
        DIRNAME=$(git worktree list | grep "\[$BRANCH\]" | cut -f1 -d' ')
        echo "$BRANCH already exists in $DIRNAME"

    else
        echo "'$1' is a new branch checking out into '$DIRNAME'"
        echo "→ git worktree add $DIRNAME -b $BRANCH"
        git worktree add $DIRNAME -b $BRANCH
        pushd > /dev/null
        $=WORKTREE_POST_CREATE
        popd > /dev/null
    fi
    pushd $DIRNAME > /dev/null
    $=WORKTREE_POST_SWITCH
    popd > /dev/null
    if [[ -n $WORKTREE_CODE_EDITOR ]];then
        confirm "Open vs code in $DIRNAME" && \
        $WORKTREE_CODE_EDITOR $DIRNAME
    fi
}

function _worktree(){
    compadd $(git worktree list | sed 's,.*\[\(.*\)\]$,\1,g') $(origin_branch)
}

function _worktree_remove(){
    compadd $(git worktree list | sed 's,.*\[\(.*\)\]$,\1,g' | grep -v '^$')
}

function _code(){
   compadd $~=WORKTREE_CODE_DIR
}

function confirm(){
    read REPLY\?"$1 [Yn]"
    case $REPLY in
        [nN]|[Nn][Oo]) return 1;;
    esac
    return 0;
}

compdef _code $WORKTREE_CODE_EDITOR
compdef _worktree worktree
compdef _worktree_remove worktree-remove

