#include <bits/stdc++.h>
using namespace std;

int minSteps(pair<int, int> knightPosition, pair<int, int> targetPosition, int size)
{
    vector<vector<int>> path = {{-2, -1}, {-1, -2}, {1, -2}, {2, -1}, {2, 1}, {1, 2}, {-1, 2}, {-2, 1}};
    vector<vector<bool>> vis(size, vector<bool>(size, false));
    priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<>> pq;

    pq.push({0, knightPosition});
    vis[knightPosition.first - 1][knightPosition.second - 1] = true;
    while (!pq.empty())
    {
        auto current = pq.top();
        pq.pop();

        int steps = current.first;
        auto position = current.second;

        if (position == targetPosition)
            return steps;

        for (auto &move : path)
        {
            int x = position.first + move[0];
            int y = position.second + move[1];

            if (x >= 1 && x <= size && y >= 1 && y <= size && !vis[x - 1][y - 1])
            {
                pq.push({steps + 1, {x, y}});
                vis[x - 1][y - 1] = true;
            }
        }
    }

    return -1;
}