#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

struct Interval
{
    int start, end;
};

bool compare(Interval a, Interval b)
{
    return a.end < b.end;
}

int maxFeedableCatsUtil(int i, const vector<Interval> &intervals, vector<int> &memo)
{
    if (i < 0)
        return 0;
    if (memo[i] != -1)
        return memo[i];

    // Option 1: Don't take the current interval
    int exclude = maxFeedableCatsUtil(i - 1, intervals, memo);

    // Option 2: Take the current interval and find the next non-overlapping interval
    int include = 1;
    int j = i - 1;
    while (j >= 0 && intervals[j].end >= intervals[i].start)
        j--;
    include += maxFeedableCatsUtil(j, intervals, memo);
    return memo[i] = max(exclude, include);
}

int maxFeedableCatsTopDown(vector<Interval> &intervals)
{
    sort(intervals.begin(), intervals.end(), compare);
    int n = intervals.size();
    vector<int> memo(n, -1);
    return maxFeedableCatsUtil(n - 1, intervals, memo);
}

int main()
{
    int t;
    cin >> t;

    while (t--)
    {
        int n, m;
        cin >> n >> m;
        vector<Interval> intervals(m);

        for (int i = 0; i < m; i++)
            cin >> intervals[i].start >> intervals[i].end;

        cout << maxFeedableCatsTopDown(intervals) << endl;
    }

    return 0;
}
