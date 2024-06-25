#include <iostream>
#include <vector>
#include <queue>

using namespace std;

int solve(int n, int m, vector<vector<int>> &grid)
{
    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    queue<pair<pair<int, int>, int>> q;
    q.push({{0, 0}, 0});

    vector<vector<bool>> visited(n, vector<bool>(m, false));
    visited[0][0] = true;

    while (!q.empty())
    {
        auto [pos, moves] = q.front();
        q.pop();
        int x = pos.first;
        int y = pos.second;

        if (x == n - 1 && y == m - 1)
            return moves;

        int newJump = grid[x][y];
        if (newJump == 0)
            continue;

        for (auto &direction : directions)
        {
            int nx = x + direction[0] * newJump;
            int ny = y + direction[1] * newJump;
            if (nx >= 0 && nx < n && ny >= 0 && ny < m && !visited[nx][ny])
            {
                visited[nx][ny] = true;
                q.push({{nx, ny}, moves + 1});
            }
        }
    }

    return -1;
}

int main()
{
    int n, m;
    cin >> n >> m;

    vector<vector<int>> grid(n, vector<int>(m));

    for (int i = 0; i < n; ++i)
    {
        string row;
        cin >> row;
        for (int j = 0; j < m; ++j)
            grid[i][j] = row[j] - '0';
    }

    int result = solve(n, m, grid);
    cout << result << endl;

    return 0;
}
