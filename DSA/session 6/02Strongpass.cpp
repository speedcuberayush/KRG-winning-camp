#include <iostream>
#include <vector>
#include <string>
using namespace std;

bool isSubsequence(const string &s, const string &password)
{
    int pos = 0;
    for (char c : s)
    {
        if (c == password[pos])
            pos++;
        if (pos == password.size())
            return true;
    }
    return false;
}

void generatePasswords(const string &s, const string &l, const string &r, string &currentPassword, int position, bool &found)
{
    if (found)
        return;

    if (position == l.size())
    {
        if (!isSubsequence(s, currentPassword))
            found = true;
        return;
    }

    for (char digit = l[position]; digit <= r[position]; ++digit)
    {
        currentPassword.push_back(digit);
        generatePasswords(s, l, r, currentPassword, position + 1, found);
        currentPassword.pop_back();
    }
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

        bool found = false;
        string currentPassword = "";
        generatePasswords(s, l, r, currentPassword, 0, found);

        cout << ((found) ? "YES" : "NO") << endl;
    }

    return 0;
}
