#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
using namespace std;

bool solve(string s, string l, string r, int m)
{
    string password = "";
    for (int i = 0; i < m; ++i)
    {
        char largest_digit = r[i];
        for (char digit = r[i]; digit >= l[i]; --digit)
        {
            if (s.find(digit, 0) == string::npos)
            {
                largest_digit = digit;
                break;
            }
        }

        if (largest_digit == l[i] - 1)
            return false;

        password += largest_digit;
    }
    return true;
}

int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        string s;
        cin >> s;
        int m;
        cin >> m;
        string l, r;
        cin >> l >> r;

        if (solve(s, l, r, m))
            cout << "YES" << endl;
        else
            cout << "NO" << endl;
    }
    return 0;
}
