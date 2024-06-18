#include <bits/stdc++.h>
using namespace std;
class Solution
{
public:
    vector<vector<int>> nearest(vector<vector<int>> grid)
    {
        // Code here
        int row = grid.size();
        int col = grid[0].size();

        queue<pair<int, int>> q;
        vector<vector<int>> ans(row, vector<int>(col, -1));

        // mark 1 to 0
        for (int i = 0; i < row; i++)
        {
            for (int j = 0; j < col; j++)
            {
                if (grid[i][j] == 1)
                {
                    q.push({i, j});
                    ans[i][j] = 0;
                }
            }
        }

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        int level = 0;
        while (!q.empty())
        {
            int size = q.size();
            for (int i = 0; i < size; i++)
            {
                int a = q.front().first;
                int b = q.front().second;
                q.pop();

                for (int k = 0; k < 4; k++)
                {
                    int na = a + dx[k];
                    int nb = b + dy[k];

                    if (na < 0 || nb < 0 || na >= row || nb >= col || ans[na][nb] != -1)
                        continue;
                    q.push({na, nb});
                    ans[na][nb] = ans[a][b] + 1;
                }
            }
        }
        return ans;
    }
};

int main()
{
    int n, m;
    cout << "Enter the number of rows: ";
    cin >> n;
    cout << "Enter the number of columns: ";
    cin >> m;

    vector<vector<int>> grid(n, vector<int>(m));
    cout << "Enter the grid elements (0s and 1s):" << endl;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            cin >> grid[i][j];

    Solution s;
    grid = s.nearest(grid);

    cout << "Updated grid with distances:" << endl;
    for (auto row : grid)
    {
        for (auto i : row)
            cout << i << " ";
        cout << endl;
    }
    return 0;
}
