#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
using namespace std;

void compute_promotion_info(int lower_limit, int upper_limit, int num_employees, const vector<vector<int>> &outperformed_by, vector<int> &promoted_lower, vector<int> &promoted_upper, vector<bool> &no_promotion_possible)
{
    vector<int> in_degree(num_employees, 0);
    vector<vector<int>> out_edges(num_employees);

    // Build the graph and calculate in-degrees
    for (const auto &edge : outperformed_by)
    {
        int from = edge[0];
        int to = edge[1];
        out_edges[from].push_back(to);
        in_degree[to]++;
    }

    // Topological sort using Kahn's algorithm
    queue<int> zero_in_degree_queue;
    for (int i = 0; i < num_employees; ++i)
    {
        if (in_degree[i] == 0)
        {
            zero_in_degree_queue.push(i);
        }
    }

    vector<int> topological_order;
    while (!zero_in_degree_queue.empty())
    {
        int current = zero_in_degree_queue.front();
        zero_in_degree_queue.pop();
        topological_order.push_back(current);
        for (int neighbor : out_edges[current])
        {
            if (--in_degree[neighbor] == 0)
            {
                zero_in_degree_queue.push(neighbor);
            }
        }
    }

    // Calculate number of promotions for each number in the interval [lower_limit, upper_limit]
    vector<int> promotions_count(num_employees + 1, 0);
    for (int i = 0; i < num_employees; ++i)
    {
        int employee = topological_order[i];
        promotions_count[i + 1] = promotions_count[i];
        if (promotions_count[i + 1] < lower_limit || promotions_count[i + 1] >= upper_limit)
        {
            promotions_count[i + 1]++;
        }
    }

    // Compute results for lower_limit and upper_limit
    promoted_lower.resize(num_employees + 1);
    promoted_upper.resize(num_employees + 1);
    no_promotion_possible.resize(num_employees + 1);

    for (int i = 1; i <= num_employees; ++i)
    {
        int promotions_needed_lower = max(0, lower_limit - promotions_count[i]);
        int promotions_needed_upper = max(0, upper_limit - promotions_count[i]);

        promoted_lower[i] = i - promotions_needed_lower;
        promoted_upper[i] = i - promotions_needed_upper;

        no_promotion_possible[i] = (i > upper_limit);
    }
}

int main()
{
    int lower_limit, upper_limit, num_employees, num_rules;
    cin >> lower_limit >> upper_limit >> num_employees >> num_rules;

    vector<vector<int>> outperformed_by(num_rules, vector<int>(2));
    for (int i = 0; i < num_rules; ++i)
    {
        cin >> outperformed_by[i][0] >> outperformed_by[i][1];
    }

    vector<int> promoted_lower, promoted_upper;
    vector<bool> no_promotion_possible;

    compute_promotion_info(lower_limit, upper_limit, num_employees, outperformed_by, promoted_lower, promoted_upper, no_promotion_possible);

    // Output results
    cout << promoted_lower[num_employees] << endl;
    cout << promoted_upper[num_employees] << endl;
    cout << count(no_promotion_possible.begin() + 1, no_promotion_possible.end(), true) << endl;

    return 0;
}
