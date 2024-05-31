#include <bits/stdc++.h>
using namespace std;

struct Node
{
    int index;
    int prev;
    int next;
};

int main()
{
    int n;
    cin >> n;

    vector<Node> nodes(n + 1);
    vector<int> heads, tails;
    unordered_map<int, vector<int>> lists;
    unordered_set<int> visited;

    for (int i = 1; i <= n; ++i)
    {
        cin >> nodes[i].prev >> nodes[i].next;
        nodes[i].index = i;
        if (nodes[i].prev == 0)
            heads.push_back(i);

        if (nodes[i].next == 0)
            tails.push_back(i);
    }

    // Traverse each list and collect nodes
    for (int head : heads)
    {
        vector<int> list;
        int current = head;
        while (current != 0)
        {
            list.push_back(current);
            visited.insert(current);
            current = nodes[current].next;
        }
        lists[head] = list;
    }

    // Sort lists by their size
    vector<vector<int>> sortedLists;
    for (const auto &pair : lists)
    {
        sortedLists.push_back(pair.second);
    }

    sort(sortedLists.begin(), sortedLists.end(), [](const vector<int> &a, const vector<int> &b)
         { return a.size() < b.size(); });

    // Merge lists
    for (size_t i = 0; i < sortedLists.size() - 1; ++i)
    {
        int tail = sortedLists[i].back();
        int head = sortedLists[i + 1].front();
        nodes[tail].next = head;
        nodes[head].prev = tail;
    }

    // Output the result
    for (int i = 1; i <= n; ++i)
        cout << nodes[i].prev << " " << nodes[i].next << endl;

    return 0;
}