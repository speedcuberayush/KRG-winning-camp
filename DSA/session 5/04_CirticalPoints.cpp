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
int solve(Node *head)
{
    if (!head || !head->next || !head->next->next)
    {
        return 0;
    }
    Node *curr = head->next;
    Node *prev = head;
    int ans = 0;
    while (curr->next)
    {
        if ((curr->next->data < curr->data && prev->data < curr->data) || (curr->next->data > curr->data && prev->data > curr->data))
            ans++;

        prev = curr;
        curr = curr->next;
    }
    return ans;
}