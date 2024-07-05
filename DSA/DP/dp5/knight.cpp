#include <bits/stdc++.h>
using namespace std;

int minSteps(pair<int, int> knightPosition, pair<int, int> targetPosition, int size)
{

    vector<vector<int>> path = {{-2, -1}, {-1, -2}, {1, -2}, {2, -1}, {2, 1}, {1, 2}, {-1, 2}, {-2, 1}};
    vector<vector<bool>> vis(size, vector<bool>(size, false));
    queue<pair<pair<int, int>, int>> q;

    q.push({knightPosition, 0});
    vis[knightPosition.first - 1][knightPosition.second - 1] = true;

    while (!q.empty())
    {
        pair<pair<int, int>, int> current = q.front();

        q.pop();

        if (current.first == targetPosition)
            return current.second;

        for (auto it : path)
        {
            int x = current.first.first + it[0];
            int y = current.first.second + it[1];
            if (x >= 1 && x <= size && y >= 1 && y <= size && !vis[x - 1][y - 1])
            {
                q.push({{x, y}, current.second + 1});
                vis[x - 1][y - 1] = true;
            }
        }
    }

    return -1;
}