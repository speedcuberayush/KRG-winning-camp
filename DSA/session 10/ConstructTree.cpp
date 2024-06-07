#include <bits/stdc++.h>
using namespace std;

class Node
{
public:
    int data;
    Node *left;
    Node *right;
    Node(int val)
    {
        this->data = val;
        this->left = NULL;
        this->right = NULL;
    }
};

class Solution
{
public:
    int findPos(int in[], int start, int end, int key)
    {
        for (int i = start; i <= end; i++)
        {
            if (key == in[i])
            {
                return i;
            }
        }
        return -1;
    }

    Node *solve(int in[], int pre[], int n, int inOrderStart, int inOrderEnd, int &posRoot)
    {
        if (posRoot >= n || inOrderStart > inOrderEnd)
            return NULL;
        int element = pre[posRoot];
        posRoot++;

        Node *root = new Node(element);
        int position = findPos(in, inOrderStart, inOrderEnd, element);

        root->left = solve(in, pre, n, inOrderStart, position - 1, posRoot);
        root->right = solve(in, pre, n, position + 1, inOrderEnd, posRoot);

        return root;
    }
    void post(Node *root, vector<int> &temp)
    {
        if (root == NULL)
            return;

        post(root->left, temp);
        post(root->right, temp);
        temp.push_back(root->data);
    }
    void levelOrder(Node *root)
    {
        queue<Node *> q;
        q.push(root);
        q.push(NULL);
        while (!q.empty())
        {
            Node *temp = q.front();
            q.pop();
            if (!q.empty())
            {
                if (temp == NULL)
                    cout << endl;
                q.push(NULL);
            }
            cout << temp->data << " ";
            if (temp->left)
                q.push(temp->left);
            if (temp->right)
                q.push(temp->right);
        }
    }
    bool show(int preorder[], int inorder[], int postorder[], int N)
    {

        int posRoot = 0;
        Node *tree = solve(inorder, preorder, N, 0, N - 1, posRoot);
        levelOrder(tree);
        // vector<int> temp;
        // post(tree, temp);

        // for (int i = 0; i < N; i++)
        //     cout << postorder[i] << endl;
        return true;
    }
};

int main(int argc, char const *argv[])
{
    Solution s;
    int preorder[] = {1, 2, 3, 4, 5, 6, 7};
    int inorder[] = {4, 2, 5, 1, 6, 3, 7};
    int postorder[] = {4, 5, 2, 6, 7, 3, 1};
    s.show(inorder, preorder, postorder, 7);
    return 0;
}
