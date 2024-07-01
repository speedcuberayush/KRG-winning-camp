#include <bits/stdc++.h>
using namespace std;

int N;
vector<vector<int>> happiness;
vector<vector<int>> dp;

int maxHappiness(int day, int prev)
{

    if (day == 0)
        return happiness[0][prev];

    if (dp[day][prev] != -1)
        return dp[day][prev];

    int result = 0;
    for (int activity = 0; activity < 3; ++activity)
        if (activity != prev)
            result = max(result, maxHappiness(day - 1, activity) + happiness[day][prev]);

    dp[day][prev] = result;
    return result;
}

int main()
{
    cin >> N;
    happiness.resize(N, vector<int>(3));
    dp.resize(N, vector<int>(3, -1));

    for (int i = 0; i < N; ++i)
        cin >> happiness[i][0] >> happiness[i][1] >> happiness[i][2];

    int result = max({maxHappiness(N - 1, 0), maxHappiness(N - 1, 1), maxHappiness(N - 1, 2)});

    cout << result << endl;

    return 0;
}
