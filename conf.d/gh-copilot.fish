# Check if the gh CLI is installed
if not command -v gh >/dev/null
    echo "GitHub CLI (gh) is not installed. Installing it now..."
    if command -v brew >/dev/null
        brew install gh
    end
end

# Check if the GitHub Copilot CLI extension is installed
if not gh extension list | grep -q github/gh-copilot
    echo "GitHub CLI Copilot (gh extension github/gh-copilot) is not installed. Installing it now..."
    gh extension install github/gh-copilot --force
end

# Set up gh copilot alias for Fish shell
# gh copilot alias -- fish | source
