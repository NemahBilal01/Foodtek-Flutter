@extends('layouts.app')

@section('content')
<div class="row">
    <div class="col">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title mb-4 d-inline">Notifications</h5>
         <a  href="#" class="btn btn-outline-dark mb-4 text-center mx-5 mt-3">Create New</a>
          <table class="table table-striped">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">user_id</th>
                <th scope="col">message</th>
                <th scope="col">is_read</th>
                <th scope="col">read_at	</th>
                <th scope="col">deleted_at</th>
                <th scope="col">action</th>
              </tr>
            </thead>

            <tbody>
              <tr>
              @foreach ($notifications as $notification )
                <th scope="row"> {{ $notification->id  }}</th>
                <td> {{ $notification->user_id }}</td>
                <td>  {{ $notification->message }}</td>
                <td> {{  $notification->is_read }}</td>
                <td> {{  $notification->read_at }}</td>
                <td> {{  $notification->deleted_at }}</td>
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
