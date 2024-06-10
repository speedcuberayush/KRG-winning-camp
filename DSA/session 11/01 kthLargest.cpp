#include <bits/stdc++.h>
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

void solve(Node *node, int &counter, int k, int &kLargest)
{
    if (!node || counter >= k)
        return;

    solve(node->right, counter, k, kLargest);
    counter++;
    if (counter == k)
    {
        kLargest = node->data;
        return;
    }
    solve(node->left, counter, k, kLargest);
}

int findKthLargest(Node *root, int k)
{
    // add your logic here
    int ans = 0;
    int count = 0;
    solve(root, count, k, ans);
    return ans;
}