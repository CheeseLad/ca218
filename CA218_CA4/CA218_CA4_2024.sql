/* Q4 */
/* Source: Checking Specific Values */
/* https://stackoverflow.com/questions/25422573/how-to-restrict-the-length-of-integer-when-creating-a-table-in-sql-server */

CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Username VARCHAR(100) NOT NULL,
    RealName_FirstName VARCHAR(100),
    RealName_LastName VARCHAR(100),
    Email VARCHAR(100) NOT NULL,
    DateOfBirth_Day SMALLINT check (DateOfBirth_Day between 1 and 31),
    DateOfBirth_Month SMALLINT check (DateOfBirth_Month between 1 and 12),
    DateOfBirth_Year MEDIUMINT UNSIGNED,
    Age SMALLINT(3) UNSIGNED,
    PasswordHash_Salt VARCHAR(200),
    PasswordHash_HashAlgorithm VARCHAR(20),
    PasswordHash_HashedPassword VARCHAR(200),
    ProfileIcon VARCHAR(500)
);

CREATE TABLE Channel (
    ChannelID INT PRIMARY KEY,
    CreatorID INT,
    ChannelIncome DECIMAL(20, 2),
    ChannelBanner VARCHAR(500),
    ChannelStatus ENUM('Banned', 'Suspended', 'Public', 'Private') NOT NULL,
    FOREIGN KEY (CreatorID) REFERENCES User(UserID)
);

CREATE TABLE Video (
    VideoID INT PRIMARY KEY,
    ChannelID INT,
    Title VARCHAR(255) NOT NULL,
    UploadDate_Day SMALLINT check (UploadDate_Day between 1 and 31),
    UploadDate_Month SMALLINT check (UploadDate_Month between 1 and 12),
    UploadDate_Year MEDIUMINT UNSIGNED,
    Description TEXT,
    MonetisationStatus ENUM('Monetised', 'Not-Monetised'),
    VisibilityStatus ENUM('Public', 'Private', 'Unlisted') NOT NULL,
    CustomSubtitles MEDIUMTEXT,
    ViewCount BIGINT,
    VideoLikeCount BIGINT,
    VideoDislikeCount BIGINT,
    LikeRatio FLOAT(3, 2),
    FOREIGN KEY (ChannelID) REFERENCES Channel(ChannelID)
);

CREATE TABLE Comment (
    CommentID INT PRIMARY KEY,
    VideoID INT,
    ParentCommentID INT NULL,
    UserID INT,
    CommentLikeCount BIGINT,
    CommentDislikeCount BIGINT,
    Content TINYTEXT,
    FOREIGN KEY (VideoID) REFERENCES Video(VideoID),
    FOREIGN KEY (ParentCommentID) REFERENCES Comment(CommentID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

/* Q5 */

INSERT INTO User (UserID, Username, RealName_FirstName, RealName_LastName, Email, DateOfBirth_Day, DateOfBirth_Month, DateOfBirth_Year, Age, PasswordHash_Salt, PasswordHash_HashAlgorithm, PasswordHash_HashedPassword, ProfileIcon)
VALUES 
(1, 'coolperson27', 'Rick', 'Jones', 'coolperson27@outlook.com', 14, 7, 1970, 54, 'XflrvR9pVE9pJNDCmVGRmUk83BeGdCUTL+AenljPbIc=', 'SHA256', '228b48a56dbc2ecf10393227ac9c9dc943881fd7a55452e12a09107476bef2b2', 'images/user/profile_1.png'),
(2, 'waffleapple483', 'Melissa', 'Wright', 'waffleapple483@gmail.com', 22, 4, 2001, 23, 'dbPpBkhhz+PjODR4pgdY1qMq4OYCvdEVZ/IlDImWImw=', 'SHA256', '5fb1679e08674059b72e271d8902c11a127bb5301b055dc77fa03932ada56a56', 'images/user/profile_2.png'),
(3, 'booktop182', 'Brian', 'Doyle', 'brian.doyle182@mail.dcu.ie', 28, 11, 1982, 42, 'NxnT6aKFnyXTo4uWJUHNRG8MVyEE9MOpXp85Vz5KorQ=', 'SHA256', 'caeba612263ca03e34528e7f142933623fc42c0ac65790ba09e1a4e37aad15c1', 'images/user/profile_3.png');

INSERT INTO Channel (ChannelID, CreatorID, ChannelIncome, ChannelBanner, ChannelStatus)
VALUES 
(1, 1, 263.38, 'images/channel/banner_1.png', 'Public'),
(2, 2, 32854.23, 'images/channel/banner_2.png', 'Private'),
(3, 3, 8562.84, 'images/channel/banner_3.png', 'Banned');

INSERT INTO Video (VideoID, ChannelID, Title, UploadDate_Day, UploadDate_Month, UploadDate_Year, Description, MonetisationStatus, VisibilityStatus, CustomSubtitles, ViewCount, VideoLikeCount, VideoDislikeCount, LikeRatio)
VALUES 
(1, 1, 'How to Make a Database in MySQL', 31, 8, 2023, 'This is an informative guide on how to make a database in MySQL', 'Monetised', 'Public', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi congue, tortor iaculis molestie pretium, elit diam venenatis urna, vitae iaculis sapien mauris vitae ante. Fusce blandit porta iaculis. Donec condimentum, erat a ultricies dictum, leo nibh sagittis dolor, eget lacinia nibh felis et lorem. In hac habitasse platea dictumst.', 94692, 5873, 352, 0.94),
(2, 3, 'Program Snake in Python', 25, 5, 2017, 'This guide will show how to program your very own version of Snake in Python', 'Monetised', 'Unlisted', 'Morbi blandit dui quis faucibus facilisis. Suspendisse potenti. Integer lobortis id lectus sed iaculis. Ut nibh erat, dignissim ac vehicula vitae, pellentesque eu turpis. Proin nisl mauris, mollis vel metus eu, dignissim semper magna. Nulla quis pharetra neque. In nec ipsum ante. Phasellus mattis malesuada pellentesque.', 452, 73, 41, 0.64),
(3, 2, 'Semantic Tableaux Guide', 17, 11, 2011, 'This video will help you master the steps involved with using semantic tableaux', 'Not-Monetised', 'Private', 'Vivamus quis lobortis eros, sit amet pulvinar mauris. Curabitur porta feugiat turpis, at pellentesque enim molestie at. Morbi congue ligula et lorem pellentesque volutpat. Aenean quis massa nibh. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis libero felis, laoreet in condimentum eget, rutrum vel mauris.', 8372, 871, 67, 0.93);

INSERT INTO Comment (CommentID, VideoID, ParentCommentID, UserID, CommentLikeCount, CommentDislikeCount, Content)
VALUES 
(1, 1, NULL, 2, 27, 4, 'Can you make more videos?'),
(2, 1,    1, 1, 50, 15, 'Yes please make more!'),
(3, 2, NULL, 3, 28, 4, 'This was a good tutorial! Feel like I can code anything in Python now.'),
(4, 2,    3, 1, 15, 3, 'The snake is slithering along.'),
(5, 3, NULL, 1, 37, 6, 'Great video! I feel like I am a logic genius now!'),
(6, 3, NULL, 3, 10, 67, 'Could you do a video on Gentzen system next?');