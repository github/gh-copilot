function ghce
    set -l GH_DEBUG "$GH_DEBUG"
    set -l GH_HOST "$GH_HOST"

    set -l __USAGE "
Wrapper around \`gh copilot explain\` to explain a given input command in natural language.

USAGE
    $argv[1] [flags] <command>

FLAGS
    -d, --debug      Enable debugging
    -h, --help       Display help usage
        --hostname   The GitHub host to use for authentication

EXAMPLES

# View disk usage, sorted by size
$argv[1] 'du -sh | sort -h'

# View git repository history as text graphical representation
$argv[1] 'git log --oneline --graph --decorate --all'

# Remove binary objects larger than 50 megabytes from git history
$argv[1] 'bfg --strip-blobs-bigger-than 50M'
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
        end
    end

    GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot explain $argv
end
