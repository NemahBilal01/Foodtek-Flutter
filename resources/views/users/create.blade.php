<!-- resources/views/users/create.blade.php -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create User</title>
</head>
<body>
    <h1>Create User</h1>

    <form action="{{ route('users.store') }}" method="POST">
        @csrf
        <label for="name">Name:</label>
        <input type="text" name="name" required><br>

        <label for="email">Email:</label>
        <input type="email" name="email" required><br>

        <label for="password">Password:</label>
        <input type="password" name="password" required><br>

        <label for="password_confirmation">Confirm Password:</label>
        <input type="password" name="password_confirmation" required><br>

        <label for="phone">Phone:</label>
        <input type="text" name="phone"><br>

        <button type="submit">Create User</button>
    </form>
    @if ($errors->any())
    <div style="color: red;">
        <ul>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
    @endif

</body>
</html>
