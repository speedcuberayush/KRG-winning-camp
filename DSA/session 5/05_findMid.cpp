#include <bits/stdc++.h>
using namespace std;

struct Node
{
    int data;
    Node *next;
    Node(int data)
    {
        this->data = data;
        this->next = nullptr;
    }
};
int getMiddleElement(Node *head)
{
    if (!head)
        return -1;

    Node *slow = head;
    Node *fast = head;

    while (fast && fast->next)
    {
        fast = fast->next->next;
        slow = slow->next;
    }

    return slow->data;
}