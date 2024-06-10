#include <bits/stdc++.h>
using namespace std;
struct TreeNode
{
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};
struct RobbedRoot
{
    int robbedRoot;
    int skippedRoot;
};

class Solution
{
private:
    RobbedRoot robDFS(TreeNode *root)
    {
        if (root == nullptr)
        {
            return RobbedRoot{0, 0};
        }

        RobbedRoot robLeft = robDFS(root->left);
        RobbedRoot robRight = robDFS(root->right);

        int robThisNode = root->val + robLeft.skippedRoot + robRight.skippedRoot;
        int skipThisNode = max(robLeft.robbedRoot, robLeft.skippedRoot) + max(robRight.robbedRoot, robRight.skippedRoot);

        return RobbedRoot{robThisNode, skipThisNode};
    }

public:
    int rob(TreeNode *root)
    {
        RobbedRoot finalState = robDFS(root);

        return max(finalState.robbedRoot, finalState.skippedRoot);
    }
};