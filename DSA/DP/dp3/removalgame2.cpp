#include <bits/stdc++.h>
using namespace std;

vector<vector<long long>> dp;

long long optimalDifference(vector<int> &nums, int i, int j)
{
    if (i == j)
        return nums[i];

    if (dp[i][j] != -1)
        return dp[i][j];

    long long chooseStart = nums[i] - optimalDifference(nums, i + 1, j);
    long long chooseEnd = nums[j] - optimalDifference(nums, i, j - 1);

    return dp[i][j] = max(chooseStart, chooseEnd);
}

long long maximum_score(vector<int> &nums)
{
    int n = nums.size();
    dp.assign(n, vector<long long>(n, -1));

    long long total_sum = accumulate(nums.begin(), nums.end(), 0LL);
    long long optimalDiff = optimalDifference(nums, 0, n - 1);

    return (total_sum + optimalDiff) / 2;
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
