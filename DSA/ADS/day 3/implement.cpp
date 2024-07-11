#include <bits/stdc++.h>
using namespace std;

class Node
{
public:
    int data;
    Node *left;
    Node *right;
    Node(int data)
    {
        this->left = NULL;
        this->right = NULL;
        this->data = data;
    }
};

void insertion(Node *&head, int data)
{
    Node *newNode = new Node(data);
    if (!head)
    {
        head = newNode;
        head->left = head;
        head->right = head;
        return;
    }
    Node *tail = head->left;
    tail->right = newNode;
    newNode->left = tail;
    newNode->right = head;
    head->left = newNode;
}

void traversal(Node *head)
{
    if (!head)
    {
        cout << "List is empty" << endl;
        return;
    }
    Node *temp = head;
    do
    {
        cout << temp->data << " ";
        temp = temp->right;
    } while (temp != head);
    cout << endl;
}

void deletion(Node *&head)
{
    if (!head)
    {
        cout << "List is empty" << endl;
        return;
    }

    Node *tail = head->left;
    if (head == tail)
    {
        delete head;
        head = NULL;
        return;
    }

    Node *newTail = tail->left;
    newTail->right = head;
    head->left = newTail;
    delete tail;
}

int main()
{
    Node *head = NULL;

    for (int i = 1; i <= 10; i++)
    {
        insertion(head, i);
        traversal(head);
    }

    for (int i = 1; i <= 5; i++)
    {
        deletion(head);
        traversal(head);
    }
    cout << numeric_limits<int>::max() << endl;
    return 0;
}
