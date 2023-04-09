import os
import sys
import openai

openai.api_key = os.environ["OPENAI_API_KEY"]

def get_code_insights(diff, file_contents):
    # use openai to get code insights
    print("Getting code insights from OpenAI...")

    response = openai.Completion.create(
        engine="text-davinci-003",
        prompt=(
            f"Analyze the following code diff and the contents of the changed files."
            f"Provide potential optimizations, observations, bugs detected, and suggested fixes:\n\n"
            f"--- Code Diff ---\n"
            f"{diff}\n\n"
            f"--- Changed Files ---\n"
            f"{file_contents}\n"
        ),
        temperature=0.5,
        max_tokens=300,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0,
    )
    
    return response.choices[0].text.strip()

if __name__ == "__main__":
    diff = sys.argv[1]
    file_contents = sys.argv[2]

    insights = get_code_insights(diff, file_contents)
    print(insights)
