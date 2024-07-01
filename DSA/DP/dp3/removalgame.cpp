#include <bits/stdc++.h>
using namespace std;

long long maximum_score(vector<int> &nums)
{
    int n = nums.size();
    vector<vector<long long>> dp(n, vector<long long>(n, 0));

    for (int i = 0; i < n; ++i)
    {
        dp[i][i] = nums[i];
    }

    for (int length = 2; length <= n; ++length)
    {
        for (int i = 0; i <= n - length; ++i)
        {
            int j = i + length - 1;
            dp[i][j] = max(nums[i] - dp[i + 1][j], nums[j] - dp[i][j - 1]);
        }
    }

    long long total_sum = accumulate(nums.begin(), nums.end(), 0LL);
    return (total_sum + dp[0][n - 1]) / 2;
}

int main()
{
    int n;
    cin >> n;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i)
    {
        cin >> nums[i];
    }
    cout << maximum_score(nums) << endl;
    return 0;
}