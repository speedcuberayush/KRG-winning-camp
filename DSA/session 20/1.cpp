#include <iostream>
#include <vector>
#include <stack>
#include <algorithm>
#include <cstring>

using namespace std;

const int MAX = 200005; 
vector<int> graph[MAX], reverseGraph[MAX], componentGraph[MAX];
bool visited[MAX];
int component[MAX], nComponents;
stack<int> Stack;

void addImplication(int u, int v)
{
    graph[u].push_back(v);
    reverseGraph[v].push_back(u);
}

void tarjanDFS1(int node)
{
    visited[node] = true;
    for (int neighbor : graph[node])
    {
        if (!visited[neighbor])
        {
            tarjanDFS1(neighbor);
        }
    }
    Stack.push(node);
}

void tarjanDFS2(int node)
{
    visited[node] = true;
    component[node] = nComponents;
    for (int neighbor : reverseGraph[node])
    {
        if (!visited[neighbor])
        {
            tarjanDFS2(neighbor);
        }
    }
}

void findSCCs(int numNodes)
{
    memset(visited, false, sizeof(visited));
    for (int i = 0; i < numNodes; i++)
    {
        if (!visited[i])
        {
            tarjanDFS1(i);
        }
    }

    memset(visited, false, sizeof(visited));
    nComponents = 0;
    while (!Stack.empty())
    {
        int node = Stack.top();
        Stack.pop();
        if (!visited[node])
        {
            tarjanDFS2(node);
            nComponents++;
        }
    }
}

int main()
{
    int n, m;
    cin >> n >> m;

    // Reading wishes and creating the implication graph
    for (int i = 0; i < n; i++)
    {
        string sign1, sign2;
        int top1, top2;
        cin >> sign1 >> top1 >> sign2 >> top2;

        int x1 = top1 * 2 - 2;
        int x1_neg = x1 + 1;
        int x2 = top2 * 2 - 2;
        int x2_neg = x2 + 1;

        if (sign1 == "+")
        {
            x1 = x1_neg;
            x1_neg = x1 - 1;
        }
        if (sign2 == "+")
        {
            x2 = x2_neg;
            x2_neg = x2 - 1;
        }

        addImplication(x1_neg, x2);
        addImplication(x2_neg, x1);
    }

    findSCCs(2 * m);

    // Check for satisfiability
    bool possible = true;
    for (int i = 0; i < m; i++)
    {
        if (component[2 * i] == component[2 * i + 1])
        {
            possible = false;
            break;
        }
    }

    if (!possible)
    {
        cout << "IMPOSSIBLE" << endl;
    }
    else
    {
        vector<char> result(m, '-');
        vector<int> assignment(nComponents, -1);

        for (int i = 0; i < nComponents; i++)
        {
            if (assignment[i] == -1)
            {
                assignment[i] = 1;
                for (int node = 0; node < 2 * m; node++)
                {
                    if (component[node] == i)
                    {
                        assignment[component[node ^ 1]] = 0;
                    }
                }
            }
        }

        for (int i = 0; i < m; i++)
        {
            if (assignment[component[2 * i]] == 1)
            {
                result[i] = '+';
            }
        }

        for (char ch : result)
        {
            cout << ch;
        }
        cout << endl;
    }

    return 0;
}
