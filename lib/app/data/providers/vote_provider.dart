import 'package:faso_vote_client/app/data/models/edit_vote.dart';
import 'package:faso_vote_client/app/data/providers/base_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/api/exception.dart';
import '../../utils/enums/api_routes.dart';
import '../../utils/helpers/image_helper.dart';
import '../models/vote.dart';
import '../models/vote_candidats.dart';
import 'api_provider.dart';

class VoteProvider with BaseProvider {
  Future<List<VoteModel>?> fetchVotes({ValueSetter<String>? onError}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.votes.path,
      );
      if (response != null) {
        final List<VoteModel> voteList = (response['data'] as List)
            .map((item) => VoteModel.fromJson(item))
            .toList();

        return voteList;
      }
      return null;
    } on ApiException catch (e) {
      if (onError != null) onError(e.message ?? '');
      return [];
    } catch (e) {
      if (onError != null) onError('Erreur inattendue: ${e.toString()}');
      return [];
    }
  }

  Future<VoteCandidats?> fetchVoteCandidats(
      {required String voteId, ValueSetter<String>? onError}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.voteCandidats.format({"vote": voteId}),
      );
      if (response != null) {
        final VoteCandidats voteCandidats =
            VoteCandidats.fromJson(response['data']);

        return voteCandidats;
      }
      return null;
    } on ApiException catch (e) {
      if (onError != null) onError(e.message ?? '');
      return null;
    } catch (e) {
      if (onError != null) onError('Erreur inattendue: ${e.toString()}');
      return null;
    }
  }

  Future<EditVote?> fetchEditVoteData(
      {required int voteId, ValueSetter<String>? onError}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.editVote.format({"vote": voteId.toString()}),
      );
      if (response != null) {
        print("Vote data $response");
        final EditVote editVote = EditVote.fromJson(response['data']);

        return editVote;
      }
      return null;
    } on ApiException catch (e) {
      if (onError != null) onError(e.message ?? '');
      return null;
    } catch (e) {
      if (onError != null) onError('Erreur inattendue: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> storeVote({
    required Map<String, dynamic> voteData,
    PlatformFile? logo,
    ValueSetter<String>? onError,
  }) async {
    try {
      showLoading();
      final List<http.MultipartFile> files = [];

      // Compress and attach logo
      if (logo != null) {
        final compressedLogo = await ImageHelper.compressImage(logo);
        if (compressedLogo != null) {
          if (compressedLogo.length > 2048 * 1024) {
            throw Exception(
                'Logo trop volumineux (${(compressedLogo.length / 1024).toStringAsFixed(2)}KB) après compression.');
          }
          files.add(http.MultipartFile.fromBytes(
            'logo',
            compressedLogo,
            filename: 'vote_logo_${DateTime.now().millisecondsSinceEpoch}.jpg',
          ));
        }
      }
      final response = await ApiProvider.multipartPost(
        auth: true,
        apiURL: ApiRoutes.votes.path,
        fields: {
          'title': voteData['event_name'],
          'description': voteData['description'],
          'start_date': voteData['start_datetime'],
          'end_date': voteData['end_datetime'],
        },
        files: files,
      );

      hideLoading();
      return response;
    } on ApiException catch (e) {
      hideLoading();
      onError?.call(e.message ?? 'Erreur lors de l’enregistrement du vote');
      return null;
    } catch (e) {
      hideLoading();
      onError?.call('Erreur inattendue: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> updateVote({
    required String voteId,
    required Map<String, dynamic> voteData,
    PlatformFile? logo,
    ValueSetter<String>? onError,
  }) async {
    try {
      showLoading();
      final List<http.MultipartFile> files = [];

      if (logo != null) {
        final compressedLogo = await ImageHelper.compressImage(logo);
        if (compressedLogo != null) {
          if (compressedLogo.length > 2048 * 1024) {
            throw Exception(
                'Logo trop volumineux (${(compressedLogo.length / 1024).toStringAsFixed(2)}KB) après compression.');
          }
          files.add(http.MultipartFile.fromBytes(
            'logo',
            compressedLogo,
            filename: 'vote_logo_${DateTime.now().millisecondsSinceEpoch}.jpg',
          ));
        }
      }

      final response = await ApiProvider.multipartUpdate(
        auth: true,
        apiURL: ApiRoutes.updateVote.format({'vote': voteId}),
        fields: {
          'title': voteData['event_name'],
          'description': voteData['description'],
          'start_date': voteData['start_datetime'],
          'end_date': voteData['end_datetime'],
          '_method': 'PUT',
        },
        files: files,
      );

      hideLoading();
      return response;
    } on ApiException catch (e) {
      hideLoading();
      onError?.call(e.message ?? 'Erreur lors de la mise à jour du vote');
      return null;
    } catch (e) {
      hideLoading();
      onError?.call('Erreur inattendue: ${e.toString()}');
      return null;
    }
  }

  Future<bool> deleteVote({
    required String voteId,
    ValueSetter<String>? onError,
  }) async {
    try {
      showLoading();
      final response = await ApiProvider.delete(
        auth: true,
        apiURL: ApiRoutes.deleteVote.format({'vote': voteId}),
      ).catchError(handleError);
      hideLoading();
      return response != null;
    } on ApiException catch (e) {
      hideLoading();
      if (onError != null) onError(e.message ?? '');
      return false;
    } catch (e) {
      hideLoading();
      debugPrint('Erreur inattendue: ${e.toString()}');
      if (onError != null) onError('Erreur inattendue: ${e.toString()}');
      return false;
    }
  }
}
