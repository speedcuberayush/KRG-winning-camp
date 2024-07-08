#include <bits/stdc++.h>
using namespace std;
int Solution::minCut(string A)
{
    int n = A.length();
    vector<int> dp(n, INT_MAX);
    vector<vector<bool>> isPalindrome(n, vector<bool>(n, false));
    for (int len = 1; len <= n; ++len)
    {
        for (int i = 0; i <= n - len; ++i)
        {
            int j = i + len - 1;
            if (len == 1)
                isPalindrome[i][j] = true;
            else if (len == 2)
                isPalindrome[i][j] = (A[i] == A[j]);

            else
                isPalindrome[i][j] = (A[i] == A[j] && isPalindrome[i + 1][j - 1]);
        }
    }

    for (int i = 0; i < n; ++i)
    {
        if (isPalindrome[0][i])
            dp[i] = 0;
        else
            for (int j = 0; j < i; ++j)
                if (isPalindrome[j + 1][i])
                    dp[i] = min(dp[i], dp[j] + 1);
    }

    return dp[n - 1];
}