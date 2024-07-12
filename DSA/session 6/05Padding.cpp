#include <iostream>
#include <vector>
#include <string>
using namespace std;

string justifyLine(const vector<string> &words, int L, int length)
{
    int spacesNeeded = L - length;
    if (words.size() == 1)
        return words[0] + string(spacesNeeded, ' ');
    int spacesBetweenWords = spacesNeeded / (words.size() - 1);

    int extraSpaces = spacesNeeded % (words.size() - 1);
    string justifiedLine = "";
    for (int i = 0; i < words.size() - 1; ++i)
    {
        justifiedLine += words[i] + string(spacesBetweenWords, ' ');
        if (extraSpaces > 0)
        {
            justifiedLine += ' ';
            extraSpaces--;
        }
    }
    justifiedLine += words.back();
    return justifiedLine;
}

vector<string> fullJustify(const vector<string> &A, int B)
{
    vector<string> result;
    vector<string> line;
    int length = 0;
    for (const string &word : A)
    {
        if (length + word.length() + line.size() > B)
        {
            result.push_back(justifyLine(line, B, length));
            line.clear();
            length = 0;
        }
        line.push_back(word);
        length += word.length();
    }
    string lastLine = line[0];
    for (int i = 1; i < line.size(); ++i)
    {
        lastLine += ' ' + line[i];
    }
    lastLine += string(B - lastLine.length(), ' ');
    result.push_back(lastLine);
    return result;
}

int main()
{
    vector<string> A = {"This", "is", "an", "example", "of", "text", "justification."};
    int B = 16;
    vector<string> justifiedText = fullJustify(A, B);
    for (const string &line : justifiedText)
    {
        cout << line << endl;
    }
    return 0;
}
