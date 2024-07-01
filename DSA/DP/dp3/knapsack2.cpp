#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>
#include <cstring>

using namespace std;

int N;
long long W;
vector<int> weights;
vector<int> values;
vector<vector<long long>> memo;

long long minWeight(int i, int value)
{
    if (value == 0)
        return 0;
    if (i == 0)
        return LLONG_MAX;

    if (memo[i][value] != -1)
        return memo[i][value];
    long long result = minWeight(i - 1, value);

    if (values[i - 1] <= value)
    {
        long long weight_with_current = minWeight(i - 1, value - values[i - 1]);
        if (weight_with_current != LLONG_MAX)
            result = min(result, weight_with_current + weights[i - 1]);
    }

    return memo[i][value] = result;
}

int main()
{
    cin >> N >> W;

    weights.resize(N);
    values.resize(N);
    for (int i = 0; i < N; ++i)
        cin >> weights[i] >> values[i];

    int maxValueSum = 0;
    for (int i = 0; i < N; ++i)
        maxValueSum += values[i];

    memo.assign(N + 1, vector<long long>(maxValueSum + 1, -1));

    int result = 0;
    for (int v = 0; v <= maxValueSum; ++v)
    {
        if (minWeight(N, v) <= W)
            result = v;
    }

    cout << result << endl;

    return 0;
}
