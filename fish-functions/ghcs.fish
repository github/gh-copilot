# gh copilot alias
# https://github.com/github/gh-copilot?tab=readme-ov-file

function ghcs
    set TARGET shell
    set -l GH_DEBUG "$GH_DEBUG"
    set -l GH_HOST "$GH_HOST"

    set -l __USAGE "
Wrapper around \`gh copilot suggest\` to suggest a command based on a natural language description of the desired output effort.
Supports executing suggested commands if applicable.

USAGE
    $argv[1] [flags] <prompt>

FLAGS
    -d, --debug              Enable debugging
    -h, --help               Display help usage
        --hostname           The GitHub host to use for authentication
    -t, --target target      Target for suggestion; must be shell, gh, git
                             default: \"$TARGET\"

EXAMPLES

- Guided experience
    $argv[1]

- Git use cases
    $argv[1] -t git \"Undo the most recent local commits\"
    $argv[1] -t git \"Clean up local branches\"
    $argv[1] -t git \"Setup LFS for images\"

- Working with the GitHub CLI in the terminal
    $argv[1] -t gh \"Create pull request\"
    $argv[1] -t gh \"List pull requests waiting for my review\"
    $argv[1] -t gh \"Summarize work I have done in issues and pull requests for promotion\"

- General use cases
    $argv[1] \"Kill processes holding onto deleted files\"
    $argv[1] \"Test whether there are SSL/TLS issues with github.com\"
    $argv[1] \"Convert SVG to PNG and resize\"
    $argv[1] \"Convert MOV to animated PNG\"
    "

    set -l OPT OPTARG OPTIND
    for arg in $argv
        switch $arg
            case --debug -d
                set GH_DEBUG api
                continue
            case --help -h
                echo "$__USAGE"
                return 0
            case --hostname
                set GH_HOST (next $argv)
                continue
            case --target -t
                set TARGET (next $argv)
                continue
        end
    end

    set -l TMPFILE (mktemp -t gh-copilotXXXXXX)
    function cleanup --on-event fish_exit
        rm -f "$TMPFILE"
    end

    if GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot suggest -t "$TARGET" $argv --shell-out "$TMPFILE"
        if test -s "$TMPFILE"
            set -l FIXED_CMD (cat $TMPFILE)
            builtin history -s -- (builtin history 1 | cut -d' ' -f4-)
            builtin history -s -- "$FIXED_CMD"
            echo
            eval -- "$FIXED_CMD"
        else
            return 1
        end
    end
end
