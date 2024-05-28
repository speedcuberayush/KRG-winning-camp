#include <bits/stdc++.h>
using namespace std;

long long calculate_distance(vector<int> &coords)
{
    sort(coords.begin(), coords.end());
    long long prefix_sum = 0;
    long long suffix_sum = accumulate(coords.begin(), coords.end(), 0LL);
    long long distance_sum = 0;
    int count = coords.size();

    for (int i = 0; i < count; ++i)
    {
        int coord = coords[i];
        suffix_sum -= coord;
        distance_sum += coord * i - prefix_sum;
        distance_sum += suffix_sum - coord * (count - i - 1);
        prefix_sum += coord;
    }

    return distance_sum;
}

int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> grid(n, vector<int>(m));
    unordered_map<int, vector<pair<int, int>>> color_coordinates;

    for (int r = 0; r < n; ++r)
    {
        for (int c = 0; c < m; ++c)
        {
            cin >> grid[r][c];
            color_coordinates[grid[r][c]].emplace_back(r, c);
        }
    }

    long long total_distance_sum = 0;

    for (auto &[color, coordinates] : color_coordinates)
    {
        if (coordinates.size() > 1)
        {
            vector<int> rows, cols;
            for (auto &[r, c] : coordinates)
            {
                rows.push_back(r);
                cols.push_back(c);
            }
            total_distance_sum += calculate_distance(rows);
            total_distance_sum += calculate_distance(cols);
        }
    }

    cout << total_distance_sum / 2 << endl;

    return 0;
}