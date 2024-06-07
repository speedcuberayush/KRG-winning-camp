#include <vector>
#include <queue>
using namespace std;

class Node
{
public:
    Node *left;
    Node *right;
    int data;

    Node(int data)
    {
        this->left = NULL;
        this->right = NULL;
        this->data = data;
    }
};

vector<int> leftView(Node *root)
{
    vector<int> result;
    if (root == NULL)
    {
        return result;
    }

    queue<Node *> q;
    q.push(root);

    while (!q.empty())
    {
        int n = q.size();

        for (int i = 0; i < n; ++i)
        {
            Node *current = q.front();
            q.pop();

            if (i == 0)
                result.push_back(current->data);

            if (current->left != NULL)
                q.push(current->left);

            if (current->right != NULL)
                q.push(current->right);
        }
    }
    return result;
}
