#include <bits/stdc++.h>
using namespace std;

class Node
{
public:
    int key, priority, size;
    Node *left, *right;
    Node(int k) : key(k), priority(rand()), size(1), left(nullptr), right(nullptr) {}
};

int getSize(Node *node)
{
    return node ? node->size : 0;
}

void rotateRight(Node *&node)
{
    Node *newRoot = node->left;
    node->left = newRoot->right;
    newRoot->right = node;
    node->size = getSize(node->left) + getSize(node->right) + 1;
    newRoot->size = getSize(newRoot->left) + getSize(newRoot->right) + 1;
    node = newRoot;
}

void rotateLeft(Node *&node)
{
    Node *newRoot = node->right;
    node->right = newRoot->left;
    newRoot->left = node;
    node->size = getSize(node->left) + getSize(node->right) + 1;
    newRoot->size = getSize(newRoot->left) + getSize(newRoot->right) + 1;
    node = newRoot;
}

void insert(Node *&root, int key)
{
    if (!root)
    {
        root = new Node(key);
        return;
    }

    if (key < root->key)
    {
        insert(root->left, key);
        if (root->left->priority > root->priority)
            rotateRight(root);
    }
    else if (key > root->key)
    {
        insert(root->right, key);
        if (root->right->priority > root->priority)
            rotateLeft(root);
    }

    root->size = getSize(root->left) + getSize(root->right) + 1;
}

void erase(Node *&root, int key)
{
    if (!root)
        return;

    if (key < root->key)
        erase(root->left, key);
    else if (key > root->key)
        erase(root->right, key);
    else
    {
        if (!root->left || !root->right)
        {
            Node *temp = root;
            root = (root->left) ? root->left : root->right;
            delete temp;
        }
        else
        {
            if (root->left->priority > root->right->priority)
                rotateRight(root);
            else
                rotateLeft(root);
            erase(root, key);
        }
    }

    if (root)
        root->size = getSize(root->left) + getSize(root->right) + 1;
}

int kthSmallest(Node *root, int k)
{
    if (!root)
        return -1;

    int leftSize = getSize(root->left);

    if (k <= leftSize)
        return kthSmallest(root->left, k);

    else if (k == leftSize + 1)
        return root->key;

    else
        return kthSmallest(root->right, k - leftSize - 1);
}

int countSmaller(Node *root, int x)
{
    if (!root)
        return 0;

    if (x <= root->key)
        return countSmaller(root->left, x);
    else
        return 1 + getSize(root->left) + countSmaller(root->right, x);
}

int main()
{
    Node *root = nullptr;
    int Q;
    cin >> Q;

    while (Q--)
    {
        char type;
        int param;
        cin >> type >> param;

        switch (type)
        {
        case 'I':
            insert(root, param);
            break;
        case 'D':
            erase(root, param);
            break;
        case 'K':
        {
            int result = kthSmallest(root, param);
            if (result == -1)
                cout << "invalid" << endl;
            else
                cout << result << endl;
            break;
        }
        case 'C':
        {
            int result = countSmaller(root, param);
            cout << result << endl;
            break;
        }
        }
    }

    return 0;
}
