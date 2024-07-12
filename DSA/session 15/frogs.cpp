#include <bits/stdc++.h>
using namespace std;

double solve(pair<int, int> &a, pair<int, int> &b)
{
    return sqrt(pow(a.first - b.first, 2) + pow(a.second - b.second, 2));
}

double findFrogDistance(int n, vector<pair<int, int>> &stones)
{

    priority_queue<pair<double, int>, vector<pair<double, int>>, greater<pair<double, int>>> pq;
    vector<double> maxJump(n, 1000000);
    vector<bool> visited(n, false);

    pq.push({0.0, 0});
    maxJump[0] = 0.0;

    while (!pq.empty())
    {
        double currentDist = pq.top().first;
        int currentIndex = pq.top().second;
        pq.pop();

        if (visited[currentIndex])
            continue;
        visited[currentIndex] = true;

        for (int i = 0; i < n; ++i)
            if (!visited[i])
            {
                double dist = solve(stones[currentIndex], stones[i]);
                double maxDist = max(currentDist, dist);
                if (maxDist < maxJump[i])
                {
                    maxJump[i] = maxDist;
                    pq.push({maxDist, i});
                }
            }
    }
    return maxJump[1];
}

int main()
{
    int t = 1;
    int n;
    while (cin >> n && n != 0)
    {

        vector<pair<int, int>> stones(n);
        for (int i = 0; i < n; ++i)
            cin >> stones[i].first >> stones[i].second;

        double frogDistance = findFrogDistance(n, stones);

        cout << "Scenario #" << t << endl;
        cout << "Frog Distance = " << fixed << setprecision(3) << frogDistance << endl;
        cout << endl;

        ++t;
    }
    return 0;
}


