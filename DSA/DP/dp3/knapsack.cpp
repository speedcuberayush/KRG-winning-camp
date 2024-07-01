#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

int main()
{
    int N;
    long long W;
    cin >> N >> W;

    vector<int> weights(N);
    vector<int> values(N);

    for (int i = 0; i < N; ++i)
        cin >> weights[i] >> values[i];

    int maxValueSum = 0;
    for (int i = 0; i < N; ++i)
        maxValueSum += values[i];

    vector<long long> dp(maxValueSum + 1, LLONG_MAX);
    dp[0] = 0;

    for (int i = 0; i < N; ++i)
    {
        int weight = weights[i];
        int value = values[i];
        for (int v = maxValueSum; v >= value; --v)
            if (dp[v - value] != LLONG_MAX)
                dp[v] = min(dp[v], dp[v - value] + weight);
    }

    int result = 0;
    for (int v = 0; v <= maxValueSum; ++v)
        if (dp[v] <= W)
            result = max(result, v);

    cout << result << endl;

    return 0;
}
