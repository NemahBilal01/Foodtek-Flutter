@extends('layouts.app')

@section('content')
<div class="row">
    <div class="col">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title mb-4 d-inline">Food Items</h5>
         <a  href="#" class="btn btn-outline-dark mb-4 text-center mx-5 mt-3">Create New</a>
          <table class="table table-striped">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">restaurant_id</th>
                <th scope="col">category_id</th>
                <th scope="col">name</th>
                <th scope="col">description</th>
                <th scope="col">price</th>
                <th scope="col">image_path</th>
                <th scope="col">is_available</th>
                <th scope="col">created_at</th>
                <th scope="col">updated_at</th>
                <th scope="col">action</th>
              </tr>
            </thead>

            <tbody>
              <tr>
              @foreach ($foodItems as $foodItem )
                <th scope="row"> {{ $foodItem->id  }}</th>
                <td> {{ $foodItem->restaurant }}</td>
                <td>  {{ $foodItem->category_id }}</td>
                <td> {{  $foodItem->name }}</td>
                <td> {{  $foodItem->description }}</td>
                <td> {{  $foodItem->price }}</td>
                <td> {{  $foodItem->image_path }}</td>
                <td> {{  $foodItem->is_available }}</td>
                <td> {{  $foodItem->created_at }}</td>
                <td> {{  $foodItem->updated_at }}</td>
                <td>
                    <a class="btn btn-primary" href="" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">Edit</a>
                    <form action="" method="POST" style="display:inline;">
                        @csrf
                        @method('DELETE')
                        <button  class="btn btn-danger" type="submit"  style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">Delete</button>
                    </form>
                </td>

              </tr>
            @endforeach
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

@endsection
