import os
import sys
import openai

openai.api_key = os.environ["OPENAI_API_KEY"]

# get the latest git staged files and diff
def get_git_diff():
    # get the latest commit
    print("Getting latest git commit...")
    commit = os.popen("git rev-parse HEAD").read().strip()

    # get the latest git diff between staged files and HEAD
    print("Getting latest git diff...")
    diff = os.popen(f"git diff --cached {commit}").read()

    # get the latest git staged files
    print("Getting latest git staged files...")
    staged_files = os.popen("git diff --name-only --cached").read().splitlines()

    return diff, staged_files
    

def get_code_insights(diff, file_contents):
    # use openai to get code insights
    print("Getting code insights from OpenAI...")
    
    response = openai.Completion.create(
        engine="text-davinci-003",
        prompt=(
            f"Analyze the following code diff and the contents of the changed files."
            f"Provide potential optimizations, observations, bugs detected, and suggested fixes. Present code snippets for bugs and fixes:\n\n"
            f"--- Code Diff ---\n"
            f"{diff}\n\n"
            f"--- Changed Files ---\n"
            f"{file_contents}\n"
        ),
        temperature=0.001,
        max_tokens=300,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0,
    )
    
    return response.choices[0].text.strip()

if __name__ == "__main__":
    diff, file_contents = get_git_diff()
    insights = get_code_insights(diff, file_contents)
    print(insights)
