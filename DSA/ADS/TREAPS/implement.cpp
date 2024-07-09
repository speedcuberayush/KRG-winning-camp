#include <bits/stdc++.h>
using namespace std;

class Node
{
public:
    int key, priority;
    Node *left, *right;
    Node(int key, int priority)
    {
        this->key = key;
        this->priority = priority;
        this->left = this->right = NULL;
    }
};

Node *rightRotate(Node *y)
{
    Node *x = y->left;
    Node *T2 = x->right;
    x->right = y;
    y->left = T2;
    return x;
}

Node *leftRotate(Node *x)
{
    Node *y = x->right;
    Node *T2 = y->left;
    y->left = x;
    x->right = T2;
    return y;
}

Node *insert(Node *root, int key, int priority)
{
    if (!root)
        return new Node(key, priority);
    if (key <= root->key)
    {
        root->left = insert(root->left, key, priority);
        if (root->left->priority > root->priority)
            root = rightRotate(root);
    }
    else
    {
        root->right = insert(root->right, key, priority);
        if (root->right->priority > root->priority)
            root = leftRotate(root);
    }

    return root;
}

Node *deleteNode(Node *root, int key)
{
    if (!root)
        return root;
    if (key < root->key)
        root->left = deleteNode(root->left, key);
    else if (key > root->key)
        root->right = deleteNode(root->right, key);
    else
    {
        if (!root->left)
        {
            Node *temp = root->right;
            delete (root);
            root = temp;
        }
        else if (!root->right)
        {
            Node *temp = root->left;
            delete (root);
            root = temp;
        }
        else if (root->left->priority < root->right->priority)
        {
            root = leftRotate(root);
            root->left = deleteNode(root->left, key);
        }
        else
        {
            root = rightRotate(root);
            root->right = deleteNode(root->right, key);
        }
    }

    return root;
}

void inorder(Node *root)
{
    if (root)
    {
        inorder(root->left);
        cout << "key: " << root->key << " | priority: " << root->priority << endl;
        inorder(root->right);
    }
}

int main()
{
    Node *root = NULL;
    root = insert(root, 50, 30);
    root = insert(root, 30, 20);
    root = insert(root, 20, 40);
    root = insert(root, 40, 50);
    root = insert(root, 70, 25);
    root = insert(root, 60, 35);
    root = insert(root, 80, 32);

    cout << "Inorder traversal of the treap: " << endl;
    inorder(root);

    cout << "Deleting node 20 " << endl;
    root = deleteNode(root, 20);
    cout << "Inorder traversal of the treap after deleting node 20: " << endl;
    inorder(root);

    return 0;
}
