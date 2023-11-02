# GitHub Copilot in the CLI

GitHub Copilot in the CLI is an extension for GitHub CLI which provides a chat-like interface in the terminal that allows you to ask questions about the command line. You can ask Copilot in the CLI to suggest a command for your use case, with `gh copilot suggest`, or to explain a command you're curious about, with `gh copilot explain`.

For more information including use cases, enabling, and limitations, see [GitHub Copilot in the CLI](https://docs.github.com/en/copilot/copilot/github-copilot-in-the-cli) section within GitHub Docs.

## Quickstart

> **Note**
> To use and install GitHub Copilot in the CLI, you must have an active GitHub Copilot subscription and have [GitHub CLI](https://cli.github.com/) installed.

1. Authenticate with OAuth token
   ```shell
   gh auth login --web -h github.com
   ```
1. Install / upgrade extension
   ```shell
   gh extension install github/gh-copilot --force
   ```
1. Generate suggestions
   ```shell
   gh copilot suggest "Install and configure git lfs"
   ```
1. Explain commands
   ```shell
   gh copilot explain 'git lfs migrate import --everything --include="*.gz,*.png,*.jar"'
   ```

## Usage

```shell
$ gh copilot --help
Your AI command line copilot.

Usage:
  copilot [command]

Available Commands:
  config      Configure options
  explain     Explain a command
  suggest     Suggest a command

Flags:
  -h, --help      help for copilot
  -v, --version   version for copilot

Use "copilot [command] --help" for more information about a command.
```

## Reporting

GitHub Copilot in the CLI sends certain metrics to our analytics system, and we want you to understand what is being
sent and why it's important to our ability to continue to improve the product and provide you with a better experience
over time.

### Why do we need usage stats?

Our team uses metrics to prioritize our work and evaluate whether we are successful in solving real users' problems after
we've released something. For example, when we release a new version and see a spike in exceptions and response ratings,
we want to understand if there is a regression or a platform nuance causing problems.

The more people who opt in to send usage stats, the more information we have to base our decision-making on. And if you
want us to take your use cases into consideration, we hope you'll opt in so we get a better idea of how you use the app
and whether or not it's meeting your needs. GitHub Copilot in the CLI will send a payload in the format below to our
analytics system unless you've opted out. We are very sensitive to the privacy of our users and we never look at the data
of specific individuals, but rather only examine aggregate data and trends to inform our product decisions.

You can change your opt-in setting at any time in `gh copilot config`.

```shell
$ gh copilot config

Welcome to GitHub Copilot CLI!
version 0.3.0-beta (2023-10-31)

I'm powered by AI, so surprises and mistakes are possible. Make sure to verify any generated code or suggestions, and share feedback so that we can learn and improve.

? What would you like to configure?
> Optional Usage Analytics

? Allow GitHub to collect optional usage data to help us improve? This data does not include your queries.  [Use arrows to move, type to filter]
> Yes
  No
```

### Example usage stats

```json
{
	"platform": "darwin",
	"architecture": "arm64",
	"version": "0.3.0-beta",
	"custom_event": "true",
	"event_parent_command": "explain",
	"event_name": "Explain",
	"sha": "089a53215fc4383179869f7f6132ce9d6e58754a",
	"thread_id": "e61d0d08-f6ba-465b-81cf-c30fd9127d70"
}
```
