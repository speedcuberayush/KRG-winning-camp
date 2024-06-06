#include <bits/stdc++.h>
using namespace std;
int KMP(string s)
{
    vector<int> LC(s.size(), 0);
    int i = 0;
    int j = 1;
    while (j < s.size())
    {
        if (s[i] == s[j])
            LC[j++] = ++i;
        else
        {
            if (i == 0)
                LC[j++] = 0;
            else
                i = LC[i - 1];
        }
    }
    return LC[s.size() - 1];
}
int main()
{
    string s = "ABCABDABACABCABACBACABCABACBCABCBCACBCBACBCBCABACBABCBCBCABCABCBACBAABC";
    cout << KMP(s);
    return 0;
}