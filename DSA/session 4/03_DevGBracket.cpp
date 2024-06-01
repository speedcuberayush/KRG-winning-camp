// #include <bits/stdc++.h>
// using namespace std;

// pair<int, int> findLongestRBS(const string &s)
// {
//     int n = s.size();
//     vector<int> arr(n, 0);
//     stack<int> stk;

//     int maxLength = 0;
//     for (int i = 0; i < n; ++i)
//     {
//         if (s[i] == '(')
//             stk.push(i);

//         else if (s[i] == ')' && !stk.empty())
//         {
//             int j = stk.top();
//             stk.pop();
//             arr[i] = i - j + 1 + (j > 0 ? arr[j - 1] : 0);
//             maxLength = max(maxLength, arr[i]);
//         }
//     }

//     int count = 0;
//     for (int length : arr)
//     {
//         if (length == maxLength)
//         {
//             count++;
//         }
//     }

//     if (maxLength == 0)
//         return {0, 1};

//     else
//         return {maxLength, count};
// }

// int main()
// {
//     string s;
//     cin >> s;

//     pair<int, int> result = findLongestRBS(s);
//     cout << result.first << " " << result.second << endl;

//     return 0;
// }

#include <bits/stdc++.h>
using namespace std;

pair<int, int> findLongestRBS(const string &s)
{
    int n = s.size();
    vector<int> start(n, 0);
    vector<int> frequency(n, 0);
    vector<int> extended(n, 0);
    stack<int> stk;

    int maxLength = 0;
    for (int i = 0; i < n; ++i)
    {
        if (s[i] == '(')
            stk.push(i);

        else if (s[i] == ')' && !stk.empty())
        {
            int j = stk.top();
            stk.pop();
            int len = i - j + 1;

            if (j > 0 && extended[j - 1] > 0)
            {
                len += extended[j - 1];
            }

            extended[i] = len;
            start[i] = j;

            if (len > maxLength)
            {
                maxLength = len;
                frequency[len] = 1;
            }
            else if (len == maxLength)
            {
                frequency[len]++;
            }
        }
    }

    if (maxLength == 0)
    {
        return {0, 1};
    }
    else
    {
        return {maxLength, frequency[maxLength]};
    }
}

int main()
{
    string s;
    cin >> s;

    pair<int, int> result = findLongestRBS(s);
    cout << result.first << " " << result.second << endl;

    return 0;
}
