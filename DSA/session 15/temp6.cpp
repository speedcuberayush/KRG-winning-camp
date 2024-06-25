#include <bits/stdc++.h>
using namespace std;

int moves[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

bool isValid(int x, int y, int r, int c)
{
    return x >= 0 && x < r && y >= 0 && y < c;
}

void bfs(vector<vector<char>> &grid, vector<vector<int>> &component, int r, int c, int id, char type)
{
    queue<pair<int, int>> q;
    q.push({r, c});
    component[r][c] = id;

    int rows = grid.size();
    int cols = grid[0].size();

    while (!q.empty())
    {
        auto [x, y] = q.front();
        q.pop();

        for (auto dir : moves)
        {
            int newX = x + dir[0];
            int newY = y + dir[1];
            if (isValid(newX, newY, rows, cols) && grid[newX][newY] == type && component[newX][newY] == 0)
            {
                component[newX][newY] = id;
                q.push({newX, newY});
            }
        }
    }
}

int main()
{
    int r, c;
    cin >> r >> c;

    vector<vector<char>> grid(r, vector<char>(c));
    for (int i = 0; i < r; ++i)
        for (int j = 0; j < c; ++j)
            cin >> grid[i][j];

    vector<vector<int>> component(r, vector<int>(c, 0));
    int id = 1;

    for (int i = 0; i < r; ++i)
        for (int j = 0; j < c; ++j)
            if (component[i][j] == 0)
                bfs(grid, component, i, j, id++, grid[i][j]);

    int n;
    cin >> n;
    while (n--)
    {
        int r1, c1, r2, c2;
        cin >> r1 >> c1 >> r2 >> c2;
        --r1;
        --c1;
        --r2;
        --c2;

        if (grid[r1][c1] != grid[r2][c2])
            cout << "neither" << endl;

        else
        {
            if (component[r1][c1] == component[r2][c2])
                cout << (grid[r1][c1] == '0' ? "binary" : "decimal") << endl;

            else
                cout << "neither" << endl;
        }
    }

    return 0;
}