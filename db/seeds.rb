Book.create!([
  {title: "Harry Potter", author: "J.K. Rowling", price: "13.49", published_date: "1997-06-26"},
  {title: "Frankenstein", author: "Mary Shelley", price: "6.49", published_date: "1818-01-01"},
  {title: "Lord of the Flies", author: "William Golding", price: "5.99", published_date: "1954-09-17"}
])
User.create!([
  {username: "Mengting"}
])
UserBook.create!([
  {user_id: 1, book_id: 2},
  {user_id: 1, book_id: 1},
  {user_id: 1, book_id: 3}
])
