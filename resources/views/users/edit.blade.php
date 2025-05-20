<!-- resources/views/users/edit.blade.php -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
</head>
<body>
    <h1>Edit User</h1>

    <form action="{{ route('users.update', $user) }}" method="POST">
        @csrf
        @method('PUT')
        <label>Name:</label>
        <input type="text" name="name" value="{{ old('name', $user->name) }}" required>
        
        <label>Email:</label>
        <input type="email" name="email" value="{{ old('email', $user->email) }}" required>

        <label>Password (leave blank to keep current):</label>
        <input type="password" name="password" placeholder="Enter new password">

        <label>Confirm Password:</label>
        <input type="password" name="password_confirmation" placeholder="Confirm new password">

        <label>Phone:</label>
        <input type="text" name="phone" value="{{ old('phone', $user->phone) }}">

        <button type="submit">Update User</button>
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
