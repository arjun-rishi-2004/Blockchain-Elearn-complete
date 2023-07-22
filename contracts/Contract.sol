// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Contract {
    
    // Structure for User Data
    struct Users{
        string userName;
    }

    // Course structure
    struct Courses{
        uint id;
        string imgsrc;
        string title;
        string descrip;
        string videourl;
        uint price;
    }

    // Array to record all users address
    address[] usersAddress;

    // Array to record all id of course
    uint[] courseIds;

    // Array to record all Courses
    mapping(uint => Courses) courseRecord;

    // Mapping of address of user to user data
    mapping (address => Users) usersRecord;

    // Events for Smart Contract
    event registerNewUserEvent(address,string,uint,string);

    // Creating a Course Provider account
    address private provider = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    // Add user
    function registerNewUser(string memory userName) external returns(string memory)  {
        if(bytes(usersRecord[msg.sender].userName).length == 0){
            usersAddress.push(msg.sender);
            usersRecord[msg.sender].userName = userName;
            emit registerNewUserEvent(msg.sender,userName,0,"Registration Successful");
            return "Registeration Successful!";
        }
        else
        emit registerNewUserEvent(msg.sender,userName,0,"You already have an Account");{
            return "You have already have an Account";
        }
    }

    // Display User Profile
    function displayUserProfile() external view returns(string memory) {
        return usersRecord[msg.sender].userName;
    }
    
     mapping(address => mapping(uint256 => bool)) public userCourses;

    // Add the function to mark a course as purchased for a user
    function addPurchasedCourse(uint256 courseId) public {
        userCourses[msg.sender][courseId] = true;
    }

    // Add a function to check if a course has been purchased by a user
    function hasPurchasedCourse(address user, uint256 courseId) public view returns (bool) {
        return userCourses[user][courseId];
    }
    // // Display Added Users
    // function displayAllUsers() external view returns (address[] memory, string[] memory) {
    //     require(msg.sender == provider,"Only Provider can access this feature");
    //     uint userCount = usersAddress.length;
    //     address[] memory addresses = new address[](userCount);
    //     string[] memory usernames = new string[](userCount);
    //     for (uint i = 0; i < userCount; i++) {
    //         addresses[i] = usersAddress[i];
    //         usernames[i] = usersRecord[usersAddress[i]].userName;
    //     }
    //     return (addresses, usernames);
    // }

    // Check for account
    function Login() external view returns (bool) {
        if(bytes(usersRecord[msg.sender].userName).length == 0){
            // User Not Registered
            return false;
        }
        else{
            // User Registered
            return true;
        }
    }

    // Check for admin
    function checkAdmin() external view returns(bool){
        if(msg.sender == provider){
            return true;
        }
        else{
            return false;
        }
    }

    // Function to get and store course
    function getCourse(uint _id,string memory _imgsrc,string memory _title,string memory _descrip,string memory _videourl,uint _price) external returns(string memory){
        if(_id > 0 && bytes(courseRecord[_id].videourl).length == 0){
            courseIds.push(_id);
            courseRecord[_id].id = _id;
            courseRecord[_id].imgsrc = _imgsrc;
            courseRecord[_id].title = _title;
            courseRecord[_id].descrip = _descrip;
            courseRecord[_id].videourl = _videourl;
            courseRecord[_id].price = _price;
            return "Course Added";
        }
        else{
            return "Cannot Add Course";
        }
    }

    // Display All Courses
    function displayCourses() external view returns(Courses[] memory){
        uint courseLength = courseIds.length;
        Courses[] memory course = new Courses[](courseLength);
        for(uint i=0; i<courseLength; i++){
            course[i] = courseRecord[courseIds[i]];
        }

        return course;
    }


//nm
}