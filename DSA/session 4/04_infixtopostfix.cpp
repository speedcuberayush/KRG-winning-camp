#include <bits/stdc++.h>
using namespace std;

int priority(char c)
{
    if (c == '+' || c == '-')
        return 1;
    if (c == '*' || c == '/')
        return 2;
    if (c == '^')
        return 3;
    return 0;
}

string solve(string exp)
{
    stack<char> stk;
    string output = "";

    for (auto i : exp)
    {
        if (i == '(')
            stk.push(i);

        else if (i == ')')
        {
            while (!stk.empty() && stk.top() != '(')
            {
                output += stk.top();
                stk.pop();
            }

            if (!stk.empty() && stk.top() == '(')
                stk.pop();
        }
        else if (isalpha(i) || isdigit(i))
            output += i;

        else
        {
            while (!stk.empty() && priority(i) <= priority(stk.top()))
            {
                output += stk.top();
                stk.pop();
            }
            stk.push(i);
        }
    }

    while (!stk.empty())
    {
        if (stk.top() != '(' && stk.top() != ')')
            output += stk.top();
        stk.pop();
    }

    return output;
}
int main()
{
    string exp;
    cin >> exp;
    cout << "Original expression: " << exp << endl;
    cout << "Postfix expression: " << solve(exp) << endl;

    return 0;
}