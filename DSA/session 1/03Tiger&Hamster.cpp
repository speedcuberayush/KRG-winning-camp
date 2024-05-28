#include <bits/stdc++.h>
using namespace std;

int main()
{
    int n;
    cin >> n;
    if (n == 0)
    {
        cout << 0 << endl;
        return 0;
    }
    string s;
    cin >> s;

    string an = s + s;

    int countH = count(s.begin(), s.end(), 'H');

    int ans = n;
    int count = 0;
    for (int i = 0; i < countH; ++i)
    {
        if (an[i] == 'T')
        {
            ++count;
        }
    }
    ans = count;

    for (int i = 1; i < n; ++i)
    {
        if (an[i - 1] == 'T')
        {
            --count;
        }
        if (an[i + countH - 1] == 'T')
        {
            ++count;
        }
        ans = min(ans, count);
    }

    cout << ans << endl;

    return 0;
}