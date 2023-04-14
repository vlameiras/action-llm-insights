# LLM Insights

LLM Insights is a tool that utilizes OpenAI's `text-davinci-003` to analyze your git diffs and provide potential optimizations, observations, bugs detected, and suggested fixes. This tool is designed to help developers improve their codebase by providing intelligent insights based on the latest changes.

## Installation
Make sure you have Python 3.6 or higher installed on your system. You can check your Python version with the following command:

```bash
python --version
```

Install the required dependencies:

```bash
pip install -r requirements.txt
```

Set up an OpenAI API key by following the instructions here. After obtaining the API key, set it as an environment variable:

```bash
export OPENAI_API_KEY=your_api_key_here
```

Add the pre-commit hook to your git repository. Place the provided `pre-commit` file in the .git/hooks folder of your repository and rename it to pre-commit. Make sure the file is executable:

```bash
chmod +x .git/hooks/pre-commit
```

## Usage

The LLM Insights tool will automatically run when you execute git commit. It will analyze the changes in the staged files and provide insights, bug detections, and fixes based on the output from OpenAI's GPT-4. If any bugs are detected, the tool will apply the suggested fixes and ask you to review and stage the changes before committing.

## Troubleshooting

If you encounter any issues while using LLM Insights, check the following:

- Ensure your OpenAI API key is set correctly as an environment variable.
- Verify that the `llm_insights.py` script and the `pre-commit` file have the correct file permissions.
- Confirm that the required Python dependencies are installed.
- Check if the pre-commit hook is correctly placed in the .git/hooks folder and renamed to pre-commit.

If you still encounter issues, please consult the error messages for more information or consider opening an issue on the project repository.

## Known issues

It only compares the current commit 
## License

LLM Insights is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file for more information.
