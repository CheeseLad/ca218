/* Q4 */

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50),
    RealName VARCHAR(100),
    Email VARCHAR(100),
    DateOfBirth DATE,
    Age INT,
    PasswordHash VARCHAR(255),
    ProfileIcon BLOB
);

CREATE TABLE Video (
    VideoID INT PRIMARY KEY AUTO_INCREMENT,
    ChannelID INT,
    Title VARCHAR(255),
    UploadDate DATE,
    Description TEXT,
    MonetisationStatus ENUM('Monetised', 'Non-monitised'),
    VisibilityStatus ENUM('Public', 'Unlisted', 'Private'),
    CustomSubtitles BOOLEAN,
    ViewCount INT,
    LikeCount INT,
    DislikeCount INT,
    LikeRatio FLOAT,
    FOREIGN KEY (ChannelID) REFERENCES User(UserID)
);

CREATE TABLE Comment (
    CommentID INT PRIMARY KEY AUTO_INCREMENT,
    VideoID INT,
    ParentCommentID INT,
    UserID INT,
    LikeCount INT,
    DislikeCount INT,
    Content TEXT,
    FOREIGN KEY (VideoID) REFERENCES Video(VideoID),
    FOREIGN KEY (ParentCommentID) REFERENCES Comment(CommentID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

/* Q5 */

INSERT INTO User (Username, RealName, Email, DateOfBirth, Age, PasswordHash, ProfileIcon) 
VALUES 
('user1', 'John Doe', 'john.doe@example.com', '1990-05-15', 31, 'hashed_password_1', NULL),
('user2', 'Jane Smith', 'jane.smith@example.com', '1985-10-20', 36, 'hashed_password_2', NULL),
('user3', 'Alice Johnson', 'alice.johnson@example.com', '1995-03-25', 26, 'hashed_password_3', NULL);

INSERT INTO Video (ChannelID, Title, UploadDate, Description, MonetisationStatus, VisibilityStatus, CustomSubtitles, ViewCount, LikeCount, DislikeCount, LikeRatio, Comments) 
VALUES 
(1, 'First Video', '2024-04-01', 'This is the first video uploaded by user1.', 'Monetised', 'Public', FALSE, 1000, 50, 5, 0.1, 'This is a great video!'),
(2, 'Second Video', '2024-04-02', 'This is the second video uploaded by user2.', 'Monetised', 'Public', FALSE, 1500, 100, 10, 0.09, 'Nice video. Keep it up!'),
(3, 'Third Video', '2024-04-03', 'This is the third video uploaded by user3.', 'Non-monetised', 'Private', TRUE, 500, 20, 2, 0.05, 'Interesting content.');

INSERT INTO Comment (VideoID, ParentCommentID, UserID, LikeCount, DislikeCount, Content) 
VALUES 
(1, NULL, 2, 10, 2, 'I enjoyed watching this video.'),
(1, 1, 1, 5, 0, 'Thanks for sharing!'),
(2, NULL, 3, 15, 3, 'Great job on this video!');
