#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
class Node
{
public:
    Node(ll s, ll e, int c)
    {
        st = s;
        ed = e;
        count = c;
        left = NULL;
        right = NULL;
    }
    ll st;
    ll ed;
    int count;
    Node *left;
    Node *right;
};
class Solution
{
public:
    Node *buildTree(vector<ll> &v, int l, int r)
    {
        if (l > r)
            return NULL;
        Node *n = new Node(v[l], v[r], 0);
        if (l == r)
            return n;
        int mid = l + r >> 1;
        n->left = buildTree(v, l, mid);
        n->right = buildTree(v, mid + 1, r);
        return n;
    }
    void insertToTree(Node *root, ll t)
    {
        if (!root)
            return;
        if (root->st <= t && t <= root->ed)
        {
            root->count++;
            insertToTree(root->left, t);
            insertToTree(root->right, t);
        }
    }
    int query(Node *root, ll lb, ll ub)
    {
        if (!root)
            return 0;
        ll st = root->st;
        ll ed = root->ed;
        if (lb <= st && ub >= ed)
            return root->count;
        if (lb > ed || ub < st)
            return 0;
        return query(root->left, lb, ub) + query(root->right, lb, ub);
    }
    int countRangeSum(vector<int> &nums, int lower, int upper)
    {
        vector<pair<ll, ll>> queries;
        for (ll i : nums)
        {
            pair<ll, ll> p = queries.empty() ? make_pair((ll)lower, (ll)upper) : queries.back();
            p.first -= i;
            p.second -= i;
            queries.push_back(p);
        }

        vector<ll> sum(nums.size(), 0);
        for (int i = 1; i < nums.size(); i++)
        {
            sum[i] = sum[i - 1] - nums[i - 1];
        }

        vector<ll> v = sum;
        sort(v.begin(), v.end());
        auto it = unique(v.begin(), v.end());
        v.erase(it, v.end());
        Node *root = buildTree(v, 0, v.size() - 1);

        int result = 0;
        for (int i = 0; i < nums.size(); i++)
        {
            insertToTree(root, sum[i]);
            result += query(root, queries[i].first, queries[i].second);
        }
        return result;
    }
};