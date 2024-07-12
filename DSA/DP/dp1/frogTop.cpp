#include <bits/stdc++.h>
using namespace std;

int solve(int i, int K, const vector<int> &h, vector<int> &dp)
{
    if (i == 0)
        return 0;

    if (dp[i] != -1)
        return dp[i];

    int min_cost = INT_MAX;
    for (int j = 1; j <= K; ++j)
        if (i - j >= 0)
            min_cost = min(min_cost, solve(i - j, K, h, dp) + abs(h[i] - h[i - j]));
    return dp[i] = min_cost;
}

int main()
{
    int N, K;
    cin >> N >> K;
    vector<int> h(N);
    for (int i = 0; i < N; ++i)
        cin >> h[i];
    vector<int> dp(N, -1);
    cout << solve(N - 1, K, h, dp) << endl;
    return 0;
}
