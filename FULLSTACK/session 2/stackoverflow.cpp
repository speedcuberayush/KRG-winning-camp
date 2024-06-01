#include <iostream>
#include <vector>
#include <string>

using namespace std;

// Forward declarations
class User;
class Content;
class UserManager;
class ContentManager;

// User class
class User
{
private:
    string username;
    bool isAdmin;

public:
    User(string username, bool isAdmin = false) : username(username), isAdmin(isAdmin) {}

    string getUsername() const
    {
        return username;
    }

    bool isAdminUser() const
    {
        return isAdmin;
    }
};

// Content class
class Content
{
private:
    string contentText;
    User *author;

public:
    Content(string contentText, User *author) : contentText(contentText), author(author) {}

    string getContentText() const
    {
        return contentText;
    }

    User *getAuthor() const
    {
        return author;
    }
};

// User Manager class
class UserManager
{
private:
    vector<User *> users;

public:
    void addUser(User *user)
    {
        users.push_back(user);
    }

    void grantPermission(User *grantee, User *targetUser)
    {
        // Implementation to grant permissions
    }

    void revokePermission(User *revoker, User *targetUser)
    {
        // Implementation to revoke permissions
    }
};

int main()
{
    // Creating users
    User *guest = new User("guest");
    User *actUser = new User("actUser");
    User *admin = new User("admin", true);

    // Adding users to UserManager
    UserManager userManager;
    userManager.addUser(guest);
    userManager.addUser(actUser);
    userManager.addUser(admin);

    // Creating content
    Content *question = new Content("How to implement a system similar to Stack Overflow?", guest);
    Content *response = new Content("You can start by defining classes like User, Content, UserManager, ContentManager, etc.", actUser);
    cout << question->getContentText() << endl;

    cout << response->getContentText() << endl;

    return 0;
}