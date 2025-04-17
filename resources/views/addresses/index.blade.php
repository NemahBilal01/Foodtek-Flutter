@extends('layouts.app')

@section('content')
<div class="row">
    <div class="col">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title mb-4 d-inline">Addresses</h5>
         <a  href="#" class="btn btn-outline-dark mb-4 text-center mx-5 mt-3">Create New</a>
          <table class="table table-striped">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">user_id</th>
                <th scope="col">address_line</th>
                <th scope="col">country</th>
                <th scope="col">state</th>
                <th scope="col">city</th>
                <th scope="col">zip_code</th>
                <th scope="col">created_at</th>
                <th scope="col">updated_at</th>
                <th scope="col">action</th>
              </tr>
            </thead>

            <tbody>
              <tr>
              @foreach ($addresses as $address )
                <th scope="row"> {{ $address->id  }}</th>
                <td> {{ $address->user_id }}</td>
                <td>  {{ $address->address_line }}</td>
                <td> {{  $address->country }}</td>
                <td> {{  $address->state }}</td>
                <td> {{  $address->city }}</td>
                <td> {{  $address->zip_code }}</td>
                <td> {{  $address->created_at }}</td>
                <td> {{  $address->updated_at }}</td>
                <td> {{  $address->deleted_at }}</td>
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
