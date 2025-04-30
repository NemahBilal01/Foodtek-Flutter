@extends('layouts.app')

@section('content')
<div class="row">
    <div class="col">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title mb-4 d-inline">Restaurants</h5>
         <a  href="#" class="btn btn-outline-dark mb-4 text-center mx-5 mt-3">Create New</a>
          <table class="table table-striped">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">owner_id</th>
                <th scope="col">name</th>
                <th scope="col">description</th>
                <th scope="col">logo_url</th>
                <th scope="col">opening_time</th>
                <th scope="col">closing_time</th>
                <th scope="col">is_active</th>
                <th scope="col">created_at</th>
                <th scope="col">updated_at</th>
                <th scope="col">Action</th>
              </tr>
            </thead>

            <tbody>
              <tr>
              @foreach ($restaurants as $restaurant )
                <th scope="row"> {{ $restaurant->id  }}</th>
                <td> {{ $restaurant->owner_id }}</td>
                <td>  {{ $restaurant->name }}</td>
                <td> {{  $restaurant->description }}</td>
                <td> {{  $restaurant->logo_url }}</td>
                <td> {{  $restaurant->opening_time }}</td>
                <td> {{  $restaurant->closing_time }}</td>
                <td> {{  $restaurant->is_active }}</td>
                <td> {{  $restaurant->created_at }}</td>
                <td> {{  $restaurant->updated_at }}</td>
                <td>
                    <a class="btn btn-primary" href="#" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">Edit</a>
                    <form action="#" method="POST" style="display:inline;">
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
